class PlayerIdentificationPacket implements ReceivePacket
{
  String id;

  PlayerIdentificationPacket() {
  }

  void initialize(String[] packetData)
  {
    id = packetData[0];
  }

  void run()
  { 
    world.thisPlayer.id = id;

    //Send PlayerInitializePacket
    networkManager.sendPacket(new PlayerInitializePacket(world.thisPlayer.username, world.thisPlayer.textureID));
  }

  String getID()
  {
    return "0";
  }

  Packet clone()
  {
    return new PlayerIdentificationPacket();
  }

  int getDataCount()
  {
    return 1;
  }
}

