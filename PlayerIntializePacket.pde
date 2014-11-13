class PlayerInitializePacket implements SendPacket
{
  String username;
  int textureID;
  int id;

  PlayerInitializePacket() {
  }
  PlayerInitializePacket(String name, int id)
  {
    username = name;
    textureID = id;
  }

  String dump()
  {
    String dumpInfo = "";
    dumpInfo += username;
    dumpInfo += "/";
    dumpInfo += textureID;

    return dumpInfo;
  }

  boolean isPrivate() { 
    return false;
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

