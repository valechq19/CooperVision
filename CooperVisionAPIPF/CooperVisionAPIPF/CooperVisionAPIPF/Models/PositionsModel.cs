using CooperVisionAPIPF.Entities;
using CooperVisionAPIPF.ModeloBD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CooperVisionAPIPF.Models
{
    public class PositionsModel
    {

        public List<PositionsEnt> ConsultarPositions()
        {
            using (var conexion = new AccessRequestsEntities())
            {
                List<PositionsEnt> respuesta = new List<PositionsEnt>();

                var datosBD = (from x in conexion.Positions
                               select x).ToList();

                if (datosBD.Count > 0)
                {
                    foreach (var item in datosBD)
                    {
                        respuesta.Add(new PositionsEnt
                        {
                            ID = item.ID,
                            Position = item.Position1
                        });
                    }
                }

                return respuesta;
            }
        }

    }
}