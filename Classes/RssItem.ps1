class RssItem
{
    [string]$Title
    [string]$Description

    RssItem($Title, $Description)
    {
        $this.Title = $Title
        $this.Description = $Description
    }

    Write([System.Xml.XmlWriter]$Writer)
    {
        $Writer.WriteStartElement('item');
        if ($this.Title) { $Writer.WriteElementString('title', $this.Title) }
        if ($this.Description) { $Writer.WriteElementString('description', $this.Description) }
        $Writer.WriteEndElement() #item
    }
}