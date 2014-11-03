interface ReceivePacket extends Packet
{  
  void initialize(String[] packetInfo);
  void run();
}
