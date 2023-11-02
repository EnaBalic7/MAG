using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.Requests
{
    public class UserRoleUpdateRequest
    {
        public bool CanReview { get; set; }

        public bool CanAskQuestions { get; set; }
    }
}
