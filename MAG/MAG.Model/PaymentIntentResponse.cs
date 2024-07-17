using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class PaymentIntentResponse
    {
        public string Id { get; set; }

        public string ClientSecret { get; set; }
    }
}
