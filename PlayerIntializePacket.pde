class PlayerInitializePacket implements SendPacket, ReceivePacket
{
  String username;
  int textureID;
  int id;
  
  PlayerInitializePacket() { }
  PlayerInitializePacket(String name, int id)
  {
    username = name;
    textureID = id;
  }
 
  void initialize(String[] packetData)
  {
    id = Integer.parseInt(packetData[0]);
    username = packetData[1];
    textureID = Integer.parseInt(packetData[2]);
  }
  
  void run()
  {
    if(id == world.thisPlayer.id)
      return;
    
    Player player = playerManager.getPlayer(id);
    
    if(player == null)
    {
      playerManager.addPlayer(new Player(world.mapW/2,world.mapH/2,64,64,0,0)); 
    }
    
    player.username = username;
    player.textureID = textureID;
    player.valid = true;
  }
  
  String dump()
  {
    String dumpInfo = "";
    dumpInfo += username;
    dumpInfo += "/";
    dumpInfo += textureID;
   
    return dumpInfo;
  }
  
  Packet clone()
  {
    return new PlayerInitializePacket(); 
  }
  
  String getID()
  {
    return "1"; 
  }
}
