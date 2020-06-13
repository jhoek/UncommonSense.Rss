using System;
using System.Management.Automation;
using System.Text;
using System.Xml;
using Microsoft.SyndicationFeed.Rss;

namespace UncommonSense.Rss
{
    [Cmdlet(VerbsCommon.New, "SyndicationFeed")]
    [OutputType(typeof(string))]
    public class NewSyndicationFeedCmdlet : Cmdlet
    {
        protected override void EndProcessing()
        {
            var xmlWriterSettings = new XmlWriterSettings() { Async = true, Indent = true };

            using (var stringWriter = new StringWriterWithEncoding(Encoding.UTF8))
            {
                using (var xmlWriter = XmlWriter.Create(stringWriter, xmlWriterSettings))
                {
                    var writer = new RssFeedWriter(xmlWriter);
                    writer.WriteTitle("Oink");
                    xmlWriter.Flush();
                }
            }
        }
    }
}
