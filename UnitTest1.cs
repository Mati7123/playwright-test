using NUnit.Framework;
using Microsoft.Playwright.NUnit;
using System.Text.RegularExpressions;

namespace playwright_test
{
    [Parallelizable(ParallelScope.Self)]
    [TestFixture]
    public class Tests : PageTest
    {
        [Test]
        public async Task IsGoogle()
        {
            await Page.GotoAsync("https://www.google.com/");
            await Expect(Page).ToHaveTitleAsync(new Regex("Google"));
        }
    }
}