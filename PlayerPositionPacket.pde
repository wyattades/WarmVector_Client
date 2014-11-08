class PlayerPositionPacket implements ReceivePacket, SendPacket
{
  float x, y, orientation;
  String id;

  PlayerPositionPacket() {
  }
  PlayerPositionPacket(float x, float y, float orientation)
  {
    x = x;
    y = y;
    orientation = orientation;
  }

  void initialize(String[] packetData)
  {
    id = packetData[0];
    x = Float.parseFloat(packetData[1]);
    y = Float.parseFloat(packetData[2]);
    orientation = Float.parseFloat(packetData[3]);
  }

  void run()
  {
    Player player = playerManager.getPlayer(id);
    if (player == null)
      return;

    player.position.x = x;
    player.position.y = y;
    player.orientation = orientation;
  }

  String dump()
  {
    String dumpInfo = "";
    dumpInfo += round(world.thisPlayer.position.x);
    dumpInfo += "/";
    dumpInfo += round(world.thisPlayer.position.y);
    dumpInfo += "/";
    dumpInfo += nf(world.thisPlayer.orientation,1,2);


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

