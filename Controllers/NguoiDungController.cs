using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using KimDongBookStore.Models;

namespace KimDongBookStore.Controllers
{
    public class NguoiDungController : Controller
    {
        KimDongBookStoreDataContext db = new KimDongBookStoreDataContext();
        // GET: NguoiDung
        public ActionResult Index()
        {
            return PartialView();
        }

        public ActionResult DangNhap()
        {
            return PartialView();
        }

        [HttpPost]
        public ActionResult DangNhap(FormCollection col)
        {
            var taikhoan = col["taikhoan"];
            var matkhau = col["matkhau"];
            KHACHHANG kh = db.KHACHHANGs.Where(a => a.TAIKHOAN == taikhoan && a.MATKHAU == matkhau).FirstOrDefault();
            if(kh == null)
            {
                return RedirectToAction("Index");
            }
            else
            {
                Session["taikhoan"] = kh;
                return RedirectToAction("Index", "Home");
            }
        }

        public ActionResult DangKy()
        {
            return PartialView();
        }

        [HttpPost]
        public ActionResult DangKy(FormCollection col)
        {
            var hoten = col["hoten"];
            var taikhoan = col["taikhoan"];
            var dienthoai = col["dienthoai"];
            var email = col["email"];
            var matkhau = col["matkhau"];
            var diachi = col["diachi"];
            //tao khach hang moi
            KHACHHANG kh = new KHACHHANG();
            kh.HOTEN = hoten;
            kh.TAIKHOAN = taikhoan;
            kh.MATKHAU = matkhau;
            kh.DIENTHOAI = dienthoai;
            kh.EMAIL = email;
            kh.DIACHI = diachi;
            db.KHACHHANGs.InsertOnSubmit(kh);
            db.SubmitChanges();
            return RedirectToAction("Index");
        }

        public ActionResult TaiKhoan()
        {
            KHACHHANG kh = (KHACHHANG)Session["taikhoan"];
            return PartialView(kh);
        }

        public ActionResult DangXuat()
        {
            Session["taikhoan"] = null;
            return PartialView();
        }
    }
}