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
    
    player.x = x;
    player.y = y;
    player.orientation = orientation;
  }
  
  String dump()
  {
    String dumpInfo = "";
    dumpInfo += int(thisPlayer.x);
    dumpInfo += "/";
    dumpInfo += int(thisPlayer.y);
    dumpInfo += "/";
    dumpInfo += thisPlayer.orientation;
    
    return dumpInfo;
  }
  
  boolean isPrivate() { return false; }
  
  Packet clone()
  {
    return new PlayerPositionPacket(); 
  }
  
  String getID()
  {
    return "3"; 
  }
}
