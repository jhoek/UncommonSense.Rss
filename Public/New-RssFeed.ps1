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
        if ($Items) { $CachedItems.AddRange($Items) }
    }

    end
    {
        $MemoryStream = New-Object -TypeName System.IO.MemoryStream

        $XmlWriterSettings = New-Object -TypeName System.Xml.XmlWriterSettings
        $XmlWriterSettings.Indent = $true
        $XmlWriterSettings.Encoding = [System.Text.Encoding]::Utf8

        $XmlWriter = [System.Xml.XmlWriter]::Create($MemoryStream, $XmlWriterSettings)

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

        [System.Text.Encoding]::Utf8.GetString($MemoryStream.ToArray())
    }
}