class NetworkManager
{
  Client client;

  HashMap<String, Packet> packetList;

  NetworkManager(Client c)
  {
    client = c;

    packetList = new HashMap<String, Packet>();
    packetList.put("-1", new PlayerTempIdentificationPacket());
    packetList.put("0", new PlayerIdentificationPacket());
    packetList.put("1", new PlayerInitializePacket());
    packetList.put("2", new PlayerConnectedListPacket());
    packetList.put("3", new PlayerPositionPacket());
  }

  void initializePlayer()
  {
    world.thisPlayer.tempID = random(0, 9999);
    sendPacket(new PlayerTempIdentificationPacket(world.thisPlayer.tempID));

    println("ID: " + world.thisPlayer.tempID);
  }

  void sendPacket(SendPacket packet)
  { 
    client.write(encodePacket(packet));
  }

  void receivePacket(ReceivePacket packet)
  {
    if (packet != null)
      packet.run();
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
    println("S: "+packetData);
    return packetData;
  }

  ReceivePacket decodePacket(String rawData)
  {
    println("R: "+ rawData);

    if (rawData.charAt(0) != '*' || rawData.charAt(rawData.length() - 1) != '*' || rawData.contains("**"))//Packets should begin and end with an asteriks
    {
      return null;
    }

    String packetData = "";
    for (int i = 1; i < rawData.length () - 1; i++)
      packetData += rawData.charAt(i);//Remove the (asteriks)s

    String[] data = packetData.split("/");//Split up the data at every /

    ReceivePacket packet = (ReceivePacket)networkManager.packetList.get(packetData.split("/")[0]);//Pull the packet based on the ID

    if (packet == null || (packet.getID() != "0" && packet.isPrivate() && Integer.parseInt(data[1]) != world.thisPlayer.id))//If the packet isn't intended for this player, then stahp
      return null;

    int indexMod = packet.isPrivate() ? 2 : 1;//If its private, then we already checked the player ID so we can chop it off
    String[] initData = new String[data.length - indexMod];//data.length = 5;  5 - 1(packet ID) - 1(player ID) = 3

    for (int i = 0; i < initData.length; i++)// We also need to skip the first two pieces of information if its private
      initData[i] = data[i+indexMod];

    packet.initialize(initData);

    return packet;
  }
}

