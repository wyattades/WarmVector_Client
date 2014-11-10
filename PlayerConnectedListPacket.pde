class PlayerConnectedListPacket implements ReceivePacket
{
  String users;
  
  PlayerConnectedListPacket() { }
  
  void initialize(String[] packetData)
  {
    users = packetData[0];
  }
  
  void run()
  {
    String[] list = users.split("~");
    
    for(int i = 0; i < list.length; i++)
    {
      String[] user = list[i].split("`");
      
      Player p = new Player(0, 0, 48, 48, 0, 0);
      
      p.id = Integer.parseInt(user[0]);
      p.username = user[1];
      p.textureID = Integer.parseInt(user[2]);
      
      playerManager.addPlayer(p);
    }
  }
  
  boolean isPrivate() { return true; }
  
  String getID()
  {
    return "2"; 
  }
  
  Packet clone()
  {
    return new PlayerConnectedListPacket(); 
  }
}
