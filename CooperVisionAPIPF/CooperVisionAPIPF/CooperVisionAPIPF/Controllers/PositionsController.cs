using CooperVisionAPIPF.Entities;
using CooperVisionAPIPF.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CooperVisionAPIPF.Controllers
{
    public class PositionsController : ApiController
    {
        PositionsModel model = new PositionsModel();

        [HttpGet]
        [Authorize]
        [Route("api/ConsultarPositions")]
        public List<PositionsEnt> ConsultarPositions()
        {
            return model.ConsultarPositions();
        }

    }
}

