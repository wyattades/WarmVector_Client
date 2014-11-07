class NetworkManager
{
  Client client;

  HashMap<String, Packet> packetList;

  NetworkManager(Client c)
  {
    client = c;

    packetList = new HashMap<String, Packet>();
    packetList.put("0", new PlayerIdentificationPacket());
    packetList.put("1", new PlayerInitializePacket());
    packetList.put("3", new PlayerPositionPacket());
  }

  void sendPacket(SendPacket packet)
  { 
    client.write(encodePacket(packet));
  }

  void receivePacket(ReceivePacket packet)
  {
    if (packet != null) packet.run();
  }

  Client getClient()
  {
    return client;
  }

  String encodePacket(SendPacket packet)
  {
    String packetData = "*";

    packetData += packet.getID();
    packetData += "/";
    packetData += packet.dump();
    
    packetData += "*";

    //println("S: "+packetData);
    
    return packetData;
  }

  ReceivePacket decodePacket(String rawData)
  {
    if (rawData.charAt(0) != '*' || rawData.charAt(rawData.length() - 1) != '*' || rawData.contains("**"))
    {
      return null;
    }

    //println("R: " + rawData);

    String packetData = "";
    for (int i = 1; i < rawData.length() - 1; i++)
      packetData += rawData.charAt(i);


    String[] data = packetData.split("/"), initData = new String[data.length - 1];

    ReceivePacket packet = (ReceivePacket)networkManager.packetList.get(packetData.split("/")[0]);

    for (int i = 0; i < data.length - 1; i++)
      initData[i] = data[i+1];
    
    if (packet.getID() == "0" || packet.getID() == "1") println("R: "+rawData);
    
    packet.initialize(initData);

    return packet;
  }
}

