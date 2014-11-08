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

  Player getPlayer(String id)
  {
    for (Player p : playerList)
      if (p.id.equals(id))
        return p;

    return null;
  }

  void sendPlayerPosition() {
    networkManager.sendPacket(new PlayerPositionPacket(world.thisPlayer.position.x, world.thisPlayer.position.y, world.thisPlayer.orientation));
  }
}

