class PlayerTempIdentificationPacket implements SendPacket
{
  float id;

  PlayerTempIdentificationPacket() { 
    id = -1;
  }

  PlayerTempIdentificationPacket(float id)
  {
    this.id = id;
  }

  String dump()
  {
    return String.valueOf(id);
  }

  String getID()
  {
    return "-1";
  }

  Packet clone()
  {
    return new PlayerTempIdentificationPacket();
  }
}

