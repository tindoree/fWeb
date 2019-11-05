using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DoanWTT;

namespace DoanWTT.Controllers
{
    public class HomeController : Controller
    {
        BanHangOnlineEntities2 db = new BanHangOnlineEntities2();
        public ActionResult Index()
        {
            var model = db.sanPhams.OrderBy(x => x.maSP).ToList();
            return View(model);
        }
       
        public ActionResult About()
        {
            return View();
        }
        public ActionResult Contact()
        {
            return View();
        }
        //public ActionResult Product()
        //{
        //    var model = db.sanPhams.OrderBy(x => x.maSP).ToList();
        //    return View(model);
        //}
        //public ActionResult Product_Detail(string id)
        //{
        //    var model = db.sanPhams.Find(id);
        //    return View(model);
        //}
        public ActionResult Search()
        {
            var tensp = Request["term"];

            var data = db.sanPhams
                .Where(p => p.tenSP.Contains(tensp))
                .Select(p => p.tenSP).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Shoping_Cart()
        {
            return View();
        }

    }
}