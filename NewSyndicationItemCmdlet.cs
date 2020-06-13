using System.Management.Automation;
using Microsoft.SyndicationFeed;

namespace UncommonSense.Rss
{
    [Cmdlet(VerbsCommon.New, "SyndicationItem")]
    [OutputType(typeof(SyndicationItem))]
    public class NewSyndicationItemCmdlet : Cmdlet
    {

    }
}