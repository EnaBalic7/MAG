﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.Requests
{
    public class UserProfilePictureInsertRequest
    {
        public byte[] ProfilePicture { get; set; } = null!;
    }
}
