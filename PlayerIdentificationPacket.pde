class PlayerIdentificationPacket implements ReceivePacket
{
  int id;

  PlayerIdentificationPacket() {
  }

  void initialize(String[] packetData)
  {
    id = Integer.parseInt(packetData[0]);
  }

  void run()
  { 
    world.thisPlayer.id = id;

    //Send PlayerInitializePacket
    networkManager.sendPacket(new PlayerInitializePacket(world.thisPlayer.username, world.thisPlayer.textureID));
  }
  
  int maxDigitCount() {
    return 20;
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

