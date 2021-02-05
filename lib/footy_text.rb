module FootyText
  def arsenal
    match = FootyFacade.get_match_info(42)
    match.format
  end

  def aston_villa
    match = FootyFacade.get_match_info(66)
    match.format
  end

  def brighton
    match = FootyFacade.get_match_info(51)
    match.format
  end

  def burnley
    match = FootyFacade.get_match_info(44)
    match.format
  end

  def chelsea
    match = FootyFacade.get_match_info(49)
    match.format
  end

  def crystal_palace
    match = FootyFacade.get_match_info(52)
    match.format
  end

  def everton
    match = FootyFacade.get_match_info(45)
    match.format
  end

  def fulham
    match = FootyFacade.get_match_info(36)
    match.format
  end

  def leeds
    match = FootyFacade.get_match_info(63)
    match.format
  end

  def leicester
    match = FootyFacade.get_match_info(46)
    match.format
  end

  def liverpool
    match = FootyFacade.get_match_info(40)
    match.format
  end

  def man_city
    match = FootyFacade.get_match_info(50)
    match.format
  end

  def man_u
    match = FootyFacade.get_match_info(33)
    match.format
  end

  def newcastle
    match = FootyFacade.get_match_info(34)
    match.format
  end

  def sheffield
    match = FootyFacade.get_match_info(62)
    match.format
  end

  def southampton
    match = FootyFacade.get_match_info(41)
    match.format
  end

  def tottenham
    match = FootyFacade.get_match_info(47)
    match.format
  end

  def west_brom
    match = FootyFacade.get_match_info(60)
    match.format
  end

  def west_ham
    match = FootyFacade.get_match_info(48)
    match.format
  end

  def wolves
    match = FootyFacade.get_match_info(39)
    match.format
  end

  def team_codes
    "Please type one of the following team codes for latest scores:
    Arsenal
    Man U
    Man City
    Chelsea
    Liverpool
    Tottenham
    Leicester
    Everton
    Southampton
    Aston Villa
    West Ham
    Newcastle
    Crystal Palace
    Wolves
    Fulham
    West Brom
    Leeds
    Burnley
    Sheffield
    Brighton"
  end
end