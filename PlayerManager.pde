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
}
