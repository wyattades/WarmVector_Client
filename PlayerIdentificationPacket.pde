class PlayerIdentificationPacket implements ReceivePacket
{
  float tempID;
  int id;
  
  PlayerIdentificationPacket() { }
  
  void initialize(String[] packetData)
  {
    tempID = Float.parseFloat(packetData[0]);
    id = Integer.parseInt(packetData[1]);
  }
  
  void run()
  { 
    if(tempID != world.thisPlayer.tempID)
    {
      return;
    }
    
    world.thisPlayer.id = id;
    
    //Send PlayerInitializePacket
    networkManager.sendPacket(new PlayerInitializePacket(world.thisPlayer.username, world.thisPlayer.textureID));
    world.thisPlayer.valid = true;
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
