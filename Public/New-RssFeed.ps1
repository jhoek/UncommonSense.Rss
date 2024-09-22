# Consider adding these channel-level elements later:
# - language
# - copyright
# - managingEditor
# - webMaster
# - category
# - generator
# - docs
# - ttl
# - image
# - rating
# - skipHours/skipDays

function New-RssFeed
{
    param
    (
        [Parameter(Mandatory)]
        [string]$Title,

        [Parameter(Mandatory)]
        [string]$Link,

        [Parameter(Mandatory)]
        [string]$Description,

        [Nullable[DateTime]]$PubDate,

        [Nullable[DateTime]]$LastBuildDate,

        [Parameter(ValueFromPipeline)]
        [RssItem[]]$Items
    )

    begin
    {
        $CachedItems = New-Object -TypeName System.Collections.Generic.List[RssItem]
    }

    process
    {
        $CachedItems.AddRange($Items)
    }

    end
    {
        $StringWriter = New-Object -TypeName System.IO.StringWriter
        $XmlWriterSettings = New-Object -TypeName System.Xml.XmlWriterSettings
        $XmlWriterSettings.Indent = $true
        $XmlWriter = [System.Xml.XmlWriter]::Create($StringWriter, $XmlWriterSettings)

        $XmlWriter.WriteStartDocument()
        $XmlWriter.WriteStartElement('rss')
        $XmlWriter.WriteAttributeString('version', '2.0')
        $XmlWriter.WriteStartElement('channel')

        $XmlWriter.WriteStartElement('title')
        $XmlWriter.WriteCData($Title)
        $XmlWriter.WriteEndElement()

        $XmlWriter.WriteElementString('link', $Link)

        $XmlWriter.WriteStartElement('description')
        $XmlWriter.WriteCData($Description)
        $XmlWriter.WriteEndElement()

        if ($PubDate) { $XmlWriter.WriteElementString('pubDate', (ConvertTo-Rfc822DateTime -DateTime $Pubdate)) }
        if ($LastBuildDate) { $XmlWriter.WriteElementString('lastBuildDate', (ConvertTo-Rfc822DateTime -DateTime $LastBuildDate)) }
        $CachedItems | ForEach-Object { $_.Write($XmlWriter) }
        $XmlWriter.WriteEndElement() # channel
        $XmlWriter.WriteEndElement() # rss
        $XmlWriter.WriteEndDocument()
        $XmlWriter.Flush()

        $StringWriter.ToString()
    }
}