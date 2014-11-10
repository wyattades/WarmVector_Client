class PlayerIdentificationPacket implements ReceivePacket
{
  String ip;
  int id;
  
  PlayerIdentificationPacket() { }
  
  void initialize(String[] packetData)
  {
    ip = packetData[0];
    id = Integer.parseInt(packetData[1]);
  }
  
  void run()
  { 
    if(ip == networkManager.client.ip())
    {
      println("IP received: " + id);
      println("IP of client: " + networkManager.client.ip());
      return;
    }
    
    thisPlayer.id = id;
    
    //Send PlayerInitializePacket
    networkManager.sendPacket(new PlayerInitializePacket(thisPlayer.username, thisPlayer.textureID));
  }
  
  String getID()
  {
    return "0"; 
  }
  
  Packet clone()
  {
    return new PlayerIdentificationPacket(); 
  }
  
  boolean isPrivate()//It really is private, but seeing as the user has no ID yet we just use the IP
  {
    return false; 
  }
  
  int getDataCount()
  {
    return 1; 
  }
}
