using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using KimDongBookStore.Models;

namespace KimDongBookStore.Controllers
{
    public class GioHangController : Controller
    {
        KimDongBookStoreDataContext db = new KimDongBookStoreDataContext();
        // GET: GioHang
        public ActionResult Index()
        {
            return View();
        }

        public List<GioHang> LayGioHang()
        {
            List<GioHang> gh = Session["giohang"] as List<GioHang>;
            if (gh == null)
            {
                gh = new List<GioHang>();
                Session["giohang"] = gh;
            }

            return gh;
        }

        public ActionResult ThemSanPham(int iMaSach, string strURL)
        {
            List<GioHang> gh = LayGioHang();

            GioHang sp = gh.Find(a => a.iMaSach == iMaSach);
            if(sp == null)
            {
                sp = new GioHang(iMaSach);
                gh.Add(sp);
            }
            else
            {
                sp.iSoLuong++;
            }
            return Redirect(strURL);
        }

        private int TongSoLuong()
        {
            int sl = 0;
            List<GioHang> gh = LayGioHang();
            if(gh != null)
            {
                sl = gh.Sum(a => a.iSoLuong);
            }

            return sl;
        }

        private decimal ThanhTien()
        {
            decimal tongtien = 0;
            List<GioHang> gh = LayGioHang();
            if (gh != null)
            {
                tongtien = gh.Sum(a => a.dThanhTien);
            }

            return tongtien;
        }

        public ActionResult GioHang()
        {
            List<GioHang> gh = LayGioHang();
            if(gh.Count == 0)
            {
                return RedirectToAction("Index", "Home");
            }
            ViewBag.TongSL = TongSoLuong();
            ViewBag.ThanhTien = ThanhTien();
            return View(gh);
        }

        public ActionResult GioHangIcon()
        {
            ViewBag.sl = TongSoLuong();
            return PartialView();
        }

        public ActionResult XoaGioHang(int iMaSach)
        {
            List<GioHang> gh = LayGioHang();
            GioHang sp = gh.SingleOrDefault(a => a.iMaSach == iMaSach);
            if(sp != null)
            {
                gh.RemoveAll(a => a.iMaSach == iMaSach);
                return RedirectToAction("GioHang");
            }
            if(gh.Count == 0)
            {
                return RedirectToAction("Index", "Home");
            }
            return RedirectToAction("GioHang");
        }

        public ActionResult CapNhatGioHang(FormCollection col, int iMaSach)
        {
            List<GioHang> gh = LayGioHang();

            GioHang sp = gh.SingleOrDefault(a => a.iMaSach == iMaSach);
            if (sp != null)
            {
                sp.iSoLuong = int.Parse(col["soluong"].ToString());
            }
            return RedirectToAction("Giohang");
        }

        public ActionResult XoaTatCaGioHang()
        {
            List<GioHang> gh = LayGioHang();
            gh.Clear();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult DatHang()
        {
            if(Session["taikhoan"] == null || Session["taikhoan"].ToString() == "")
            {
                return RedirectToAction("DangNhap", "NguoiDung");
            }
            if(Session["giohang"] == null)
            {
                return RedirectToAction("Index", "Home");
            }
            KHACHHANG khachhang = (KHACHHANG)Session["taikhoan"];
            ViewBag.Hoten = khachhang.HOTEN;
            ViewBag.DiaChi = khachhang.DIACHI;
            ViewBag.DienThoai = khachhang.DIENTHOAI;
            ViewBag.TongTien = ThanhTien();
            return View(LayGioHang());
        }

        public ActionResult ThanhToan()
        {
            DONDATHANG ddh = new DONDATHANG();
            KHACHHANG kh = (KHACHHANG)Session["taikhoan"];
            List<GioHang> gh = LayGioHang();
            ddh.MAKH = kh.MAKH;
            ddh.NGAYDAT = DateTime.Now;
            ddh.NGAYGIAO = DateTime.Now;
            ddh.TINHTRANGGIAOHANG = "Xu ly";
            ddh.DATHANHTOAN = false;
            db.DONDATHANGs.InsertOnSubmit(ddh);
            db.SubmitChanges();
            foreach(var item in gh)
            {
                CHITIETDONHANG ctdh = new CHITIETDONHANG();
                ctdh.MADONHANG = ddh.MADONHANG;
                ctdh.MASACH = item.iMaSach;
                ctdh.SOLUONG = item.iSoLuong;
                db.CHITIETDONHANGs.InsertOnSubmit(ctdh);
            }
            db.SubmitChanges();
            Session["giohang"] = null;
            return RedirectToAction("XacNhan", "GioHang");
        }

        public ActionResult XacNhan()
        {
            return View();
        }
    }
}