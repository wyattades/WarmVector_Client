class PlayerManager
{
  ArrayList<Player> playerList;
  
  PlayerManager()
  {
    playerList = new ArrayList<Player>(); 
  }
  
  void addPlayer(Player player)
  {
    playerList.add(player);
  }
  
  Player getPlayer(int id)
  {
    for(Player p : playerList)
      if(p.id == id)
        return p;
     
    return null;
  }
  
  void sendPlayerPosition()
  {
//    if(world.thisPlayer.valid)
//    {
      println("FOUOEUFBE");
      networkManager.sendPacket(new PlayerPositionPacket((world.thisPlayer.position.x, world.thisPlayer.position.y, world.thisPlayer.orientation)); 
//    }
  }
}
