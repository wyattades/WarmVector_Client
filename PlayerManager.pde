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
    if(thisPlayer.valid)
    {
      networkManager.sendPacket(new PlayerPositionPacket(thisPlayer.x, thisPlayer.y, thisPlayer.orientation));
    } 
  }
}
