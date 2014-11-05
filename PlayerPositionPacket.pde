class PlayerPositionPacket implements ReceivePacket, SendPacket
{
  float x, y, orientation;
  int id;
  
  PlayerPositionPacket() { }
  PlayerPositionPacket(float x, float y, float orientation)
  {
    x = x;
    y = y;
    orientation = orientation; 
  }
  
  void initialize(String[] packetData)
  {
    id = Integer.parseInt(packetData[0]);
    x = Float.parseFloat(packetData[1]);
    y = Float.parseFloat(packetData[2]);
    orientation = Float.parseFloat(packetData[3]);
  }
  
  void run()
  {
    Player player = playerManager.getPlayer(id);
    if(player == null)
      return;
    
    player.position.x = x;
    player.position.y = y;
    player.orientation = orientation;
  }
  
  String dump()
  {
    String dumpInfo = "";
    dumpInfo += world.thisPlayer.position.x;
    dumpInfo += "/";
    dumpInfo += world.thisPlayer.position.y;
    dumpInfo += "/";
    dumpInfo += world.thisPlayer.orientation;
    
    
    return dumpInfo;
  }
  
  Packet clone()
  {
    return new PlayerPositionPacket(); 
  }
  
  String getID()
  {
    return "3"; 
  }
}
