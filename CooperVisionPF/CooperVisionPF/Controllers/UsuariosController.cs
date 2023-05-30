using CooperVisionPF.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CooperVisionPF.Controllers
{
    public class UsuariosController : Controller
    {

        PositionsModel modelPositions = new PositionsModel();

        public ActionResult Index()
        {
            return View();
        }
    }

    [HttpGet]
    public ActionResult Dropdown(long q)
    {
        var resultado = model.PositionsModel(q);

        ViewBag.ListadoPositions = modelPositions.PositionsCons();

        return View(resultado);
    }
}