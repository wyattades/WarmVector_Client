class PlayerPositionPacket implements ReceivePacket, SendPacket
{
  float x, y, orientation;
  int id;

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
    id = Integer.parseInt(packetData[0]);
    x = Float.parseFloat(packetData[1]);
    y = Float.parseFloat(packetData[2]);
    orientation = Float.parseFloat(packetData[3]);
  }

  int maxDigitCount() {
    return 100;
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
    dumpInfo += nf(world.thisPlayer.position.x, 4, 1);
    dumpInfo += "/";
    dumpInfo += nf(world.thisPlayer.position.y, 4, 1);
    dumpInfo += "/";
    dumpInfo += nf(world.thisPlayer.orientation, 1, 2);


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

