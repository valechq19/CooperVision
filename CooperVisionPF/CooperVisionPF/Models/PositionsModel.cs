using CooperVisionPF.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Net.Http;
using System.Web;
using System.Net.Http.Json;
using System.Web.Mvc;

namespace CooperVisionPF.Models
{
    public class PositionsModel
    {

        public List<SelectListItem> ConsultarPositions()
        {
            using (var client = new HttpClient())
            {
                string url = "https://localhost:44302/api/ConsultarPositions";

                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Current.Session["Token"].ToString());
                HttpResponseMessage respuesta = client.GetAsync(url).GetAwaiter().GetResult();

                if (respuesta.IsSuccessStatusCode)
                {
                    var datos = respuesta.Content.ReadFromJsonAsync<List<PositionsEnt>>().Result;

                    List<SelectListItem> PositionsCombo = new List<SelectListItem>();
                    foreach (var item in datos)
                    {
                        PositionsCombo.Add(new SelectListItem
                        {
                            Value = item.ID.ToString(),
                            Text = item.Position
                        });
                    }

                    return PositionsCombo;
                }
                
                return new List<SelectListItem>();
            }
        }

}
}