using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using KimDongBookStore.Models;

namespace KimDongBookStore.Controllers
{
    public class HomeController : Controller
    {
        KimDongBookStoreDataContext db = new KimDongBookStoreDataContext();

        public List<SACH> SachTheoChuDe(int chude, int soluong)
        {
            return db.SACHes.Take(soluong).OrderByDescending(a => a.NGAYCAPNHAT).Where(a => a.MACD == chude).ToList();
        }

        public ActionResult Index()
        {
            var chude = db.CHUDEs.ToList();
            return View(chude);
        }

        public ActionResult AnPhamKiNiem()
        {
            var sach = SachTheoChuDe(1, 5);
            return PartialView(sach);
        }
        public ActionResult SACHMOI()
        {
            var sach = SachTheoChuDe(2, 5);
            return PartialView(sach);
        }
        public ActionResult SACHBANCHAY()
        {
            var sach = SachTheoChuDe(3, 5);
            return PartialView(sach);
        }
        public ActionResult COMBO()
        {
            var sach = SachTheoChuDe(4, 5);
            return PartialView(sach);
        }
        public ActionResult MANGA()
        {
            var sach = SachTheoChuDe(5, 5);
            return PartialView(sach);
        }
        public ActionResult DORAEMON()
        {
            var sach = SachTheoChuDe(6, 5);
            return PartialView(sach);
        }
        public ActionResult WINGSBOOK()
        {
            var sach = SachTheoChuDe(7, 5);
            return PartialView(sach);
        }
        public ActionResult SHOPNOW()
        {
            var sach = SachTheoChuDe(8, 5);
            return PartialView(sach);
        }

        public ActionResult DanhMuc()
        {
            var danhmuc = db.DANHMUCs.ToList();
            return PartialView(danhmuc);
        }

        public ActionResult ChitietDanhMuc(int id = 0)
        {
            List<SACH> sach;
            if (id == 0) sach = db.SACHes.ToList();
            else sach = db.SACHes.Where(a => a.MADM == id).ToList();
            return View(sach);
        }

        public ActionResult ChiTietSanPham(int id)
        {
            var sach = db.SACHes.Where(a => a.MASACH == id).SingleOrDefault();
            return View(sach);
        }
    }
}