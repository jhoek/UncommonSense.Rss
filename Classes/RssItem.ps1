class RssItem
{
    [string]$Title
    [string]$Description
    [string]$ID
    [string]$Link
    [Nullable[DateTime]]$PubDate

    RssItem($Title)
    {
        $this.Title = $Title
    }

    Write([System.Xml.XmlWriter]$Writer)
    {
        $Writer.WriteStartElement('item')

        $Writer.WriteStartElement('title')
        $Writer.WriteCData($this.Title)
        $Writer.WriteEndElement()

        if ($this.Description)
        {
            $Writer.WriteStartElement('description')
            $Writer.WriteCData($this.Description)
            $Writer.WriteEndElement()
        }
        if ($this.ID) { $Writer.WriteElementString('guid', $this.ID) }
        if ($this.Link) { $Writer.WriteElementString('link', $this.Link) }
        if ($this.PubDate) { $Writer.WriteElementString('pubDate', $this.PubDate.ToString('ddd, d MMM yyyy HH:mm:ss zzz')) }
        $Writer.WriteEndElement() #item
    }
}