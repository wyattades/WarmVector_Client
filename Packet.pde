interface Packet extends Cloneable
{
  String getID();
  
  Packet clone();
}
