xml.rss(version: "2.0" ){
  xml.channel{
    xml.title("Kiprosh Climber news ")
    xml.link("http://localhost:3000/incidents")
    for incident in @incidents
      xml.item{
        xml.title(incident.title)
        xml.description(incident.description)
        xml.link("http://localhost:3000/incidents/#{incident.id}")
      }
    end
  }
}
