using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using KimDongBookStore.Models;
using PagedList;
using PagedList.Mvc;


namespace KimDongBookStore.Controllers
{
    public class AdminController : Controller
    {
        KimDongBookStoreDataContext db = new KimDongBookStoreDataContext();
        // GET: Admin
        public ActionResult Index()
        {
            if(Session["admin"] == null)
            {
                return RedirectToAction("DangNhap");
            }
            return View();
        }

        public ActionResult DangNhap()
        {
            return View();
        }

        [HttpPost]
        public ActionResult DangNhap(FormCollection col)
        {
            var taikhoan = col["taikhoan"];
            var matkhau = col["matkhau"];
            ADMIN admin = db.ADMINs.SingleOrDefault(a => a.TAIKHOAN == taikhoan && a.MATKHAU == matkhau);

            if(admin == null)
            {
                return RedirectToAction("DangNhap");
            }
            else
            {
                Session["admin"] = admin;
                return RedirectToAction("Index");
            }
        }

        public ActionResult QuanLiSach(int ?page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 2;
            return View(db.SACHes.ToList().OrderBy(n => n.MASACH).ToPagedList(pageNumber, pageSize));
        }

        public ActionResult ThemMoi()
        {
            ViewBag.MACD = new SelectList(db.CHUDEs.ToList().OrderBy(a => a.TENCHUDE), "MACD", "TENCHUDE");
            ViewBag.MADM = new SelectList(db.DANHMUCs.ToList().OrderBy(a => a.TENDM), "MADM", "TENDM");
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ThemMoi(SACH sach, HttpPostedFileBase file)
        {
            ViewBag.MACD = new SelectList(db.CHUDEs.ToList().OrderBy(a => a.TENCHUDE), "MACD", "TENCHUDE");
            ViewBag.MADM = new SelectList(db.DANHMUCs.ToList().OrderBy(a => a.TENDM), "MADM", "TENDM");

            if(file == null)
            {
                ViewBag.ThongBao = "Vui lòng chọn ảnh bìa";
                return View();
            }
            else
            {
                if(ModelState.IsValid)
                {
                    var fileName = Path.GetFileName(file.FileName);

                    var path = Path.Combine(Server.MapPath("~/Content/img/product"), fileName);
                    if (System.IO.File.Exists(path))
                    {
                        ViewBag.ThongBao = "Hình ảnh đã tồn tại";
                    }
                    else
                    {
                        file.SaveAs(path);
                    }
                    sach.ANHBIA = fileName;
                    db.SACHes.InsertOnSubmit(sach);
                    db.SubmitChanges();
                }
                return RedirectToAction("QuanLiSach");
            }
        }

        public ActionResult ChiTietSach(int id)
        {
            return View(db.SACHes.Single(a => a.MASACH == id));
        }

        public ActionResult XoaSach(int id)
        {
            SACH sach = db.SACHes.SingleOrDefault(a => a.MASACH == id);
            ViewBag.MaSach = sach.MASACH;
            if(sach == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sach);
        }

        [HttpPost]
        public ActionResult XoaSach(int id, FormCollection col)
        {
            SACH sach = db.SACHes.SingleOrDefault(a => a.MASACH == id);
            db.SACHes.DeleteOnSubmit(sach);
            db.SubmitChanges();
            return RedirectToAction("QuanLiSach", "Admin");
        }

        public ActionResult Update()
        {
            return View();
        }

        public ActionResult SuaSach(int id)
        {
            SACH sach = db.SACHes.SingleOrDefault(a => a.MASACH == id);
            if(sach == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            ViewBag.MaCD = new SelectList(db.CHUDEs.ToList().OrderBy(a => a.TENCHUDE), "MaCD", "TENCHUDE", sach.MACD);
            ViewBag.MaDM = new SelectList(db.DANHMUCs.ToList().OrderBy(a => a.TENDM), "MaDM", "TENDM", sach.MADM);
            return View(sach);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult SuaSach(SACH sach, FormCollection col, HttpPostedFileBase fileUpload)
        {
            sach.TENSACH = col["tensach"];
            sach.GIABAN = decimal.Parse(col["giaban"]);
            sach.MOTA = col["mota"];
            sach.NGAYCAPNHAT = DateTime.Now;
            sach.SOLUONGTON = int.Parse(col["soluongton"]);
            sach.MACD = int.Parse(col["macd"]);
            sach.MADM = int.Parse(col["madm"]);
            sach.TACGIA = col["tacgia"];
            sach.SALE = double.Parse(col["sale"]);
            sach.ISBN = col["isbn"];
            sach.DOITUONG = col["doituong"];
            sach.KHUONKHO = col["khuonkho"];
            sach.SOTRANG = int.Parse(col["sotrang"]);
            sach.DINHDANG = col["dinhdang"];
            sach.TRONGLUONG = int.Parse(col["trongluong"]);
            sach.BOSACH = col["bosach"] ?? "";
            ViewBag.MaCD = new SelectList(db.CHUDEs.ToList().OrderBy(a => a.TENCHUDE), "MaCD", "TENCHUDE", sach.MACD);
            ViewBag.MaDM = new SelectList(db.DANHMUCs.ToList().OrderBy(a => a.TENDM), "MaDM", "TENDM", sach.MADM);
            
                if (ModelState.IsValid)
                {
                    if(fileUpload != null)
                {
                    var fileName = Path.GetFileName(fileUpload.FileName);
                    var path = Path.Combine(Server.MapPath("~/Content/img/product"), fileName);

                    if (System.IO.File.Exists(path))
                    {
                        ViewBag.ThongBao = "Hình ảnh đã tồn tại";
                        return View(sach);
                    }
                    else
                    {
                        fileUpload.SaveAs(path);
                        sach.ANHBIA = fileName;
                    }
                }
                    UpdateModel(sach);
                    db.SubmitChanges();
                }
                return RedirectToAction("QuanLiSach");
        }
    }
}