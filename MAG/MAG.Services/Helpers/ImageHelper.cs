using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services.Helpers
{
    public static class ImageHelper
    {
        public static byte[] ConvertImageToByteArray(string imagePath)
        {
            return File.ReadAllBytes(imagePath);
        }
    }
}
