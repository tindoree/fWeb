using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DoanWTT;

namespace DoanWTT.Controllers
{
    public class ProductController : Controller
    {
        BanHangOnlineEntities2 db = new BanHangOnlineEntities2();
        // GET: Product
        public ActionResult Index()
        {
            var model = db.sanPhams.OrderBy(x => x.maSP).ToList();
            return View(model);
        }
        public ActionResult Detail(string id)
        {
            var model = db.sanPhams.Find(id);
            return View(model);
        }
        // Search
        public ActionResult Search(String keywords = "")
        {
            if (keywords != "")
            {
                var model = db.sanPhams
                .Where(item => item.tenSP.Contains(keywords));
                return View(model);
            }
            return View(db.sanPhams);
        }
    }
}