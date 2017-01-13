using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Data;
using TBSeed;
using System.Dynamic;
using KVConnector.Properties;

namespace KVConnector
{
    class KVHelper
    {
        public static List<Seed> GetApproveRequestSeedList(SeedDataAccess seedDataAccess, dynamic objDictionary)
        {
            List<Seed> seedList = new List<Seed>();

            JObject jObjDict = JObject.FromObject(objDictionary);
            JToken jBundle = jObjDict.SelectToken("orderBundle");
            JToken orderMaster = jBundle.SelectToken("orderMaster");
            JToken orderDetails = jBundle.SelectToken("orderDetails");
            JToken orderImpDetails = jBundle.SelectToken("orderImpDetails");
            JToken newCard = jBundle.SelectToken("newCard");
            var userId = jObjDict.GetValue("userId").ToString();
            #region OrderMaster

            Action<Dictionary<string, object>, Dictionary<string, object>, List<Seed>> preSaveAction = (d1, d2, l) =>
            {
                string maxOrderNo = seedDataAccess.ExecuteScalarAsString(SqlResource.GetMaxOrderNumber);
                int maxNo = int.Parse(maxOrderNo);
                d1["OrderNo"] = maxNo + 1;
            };

            Action<Dictionary<string, object>, Dictionary<string, object>, List<Seed>> postSaveAction = (d1, d2, l) =>
            {
                var value = d1["OrderNo"];
                List<SqlParameter> parms = new List<SqlParameter>();
                parms.Add(new SqlParameter("value", value));
                seedDataAccess.ExecuteScalar(SqlResource.SetMaxOrderNumber, parms);
            };

            dynamic orderMasterObject = orderMaster.ToObject<dynamic>();
            orderMasterObject.OrderNo = "1";
            IDictionary<string, object> orderMasterDict = SeedUtil.GetDictFromDynamicObject(orderMasterObject);
            var seed = new Seed()
            {
                TableName = "OrderMaster",
                TableDict = orderMasterDict,
                IsCustomIDGenerated = false,
                PKeyColName = "Id",
                PKeyTagName = "order",
                PreSaveAction = preSaveAction,
                PostSaveAction = postSaveAction
            };
            seedList.Add(seed);
            #endregion

            #region OrderDetails
            List<dynamic> orderDetailsList = orderDetails.ToList<dynamic>();

            KeyValuePair<string, string> kvDetails = new KeyValuePair<string, string>("OrderId", "order");
            List<KeyValuePair<string, string>> kvListDetails = new List<KeyValuePair<string, string>>();
            kvListDetails.Add(kvDetails);

            orderDetailsList.ForEach(x =>
            {
                var seedOrderDetails = new Seed()
                {
                    PKeyColName = "Id",
                    TableName = "OrderDetails",
                    TableDict = SeedUtil.GetDictFromDynamicObject(x),
                    IsCustomIDGenerated = false,
                    DetailsTableColNameTagNamePairs = kvListDetails
                };
                seedList.Add(seedOrderDetails);
            });
            #endregion

            #region OrderImpDetails
            KeyValuePair<string, string> kvImpDetails = new KeyValuePair<string, string>("OrderId", "order");
            List<KeyValuePair<string, string>> kvImpListDetails = new List<KeyValuePair<string, string>>();
            kvImpListDetails.Add(kvImpDetails);

            object orderImpDetailsId = null;
            Action<Dictionary<string, object>, Dictionary<string, object>, List<Seed>> postSaveActionOrderImpDetails = (d1, d2, l) =>
            {
                orderImpDetailsId = d2["orderImpDetails"];
            };


            var seedOrderImpDetails = new Seed()
            {
                PKeyColName = "Id",
                TableName = "OrderImpDetails",
                TableDict = SeedUtil.GetDictFromDynamicObject(orderImpDetails),
                IsCustomIDGenerated = false,
                DetailsTableColNameTagNamePairs = kvImpListDetails,
                PostSaveAction = postSaveActionOrderImpDetails,
                PKeyTagName = "orderImpDetails",
            };
            seedList.Add(seedOrderImpDetails);
            #endregion
            
            if (newCard != null) //save new card in PaymentMethods table and store new cardId in orderImpDetails
            {
                var tableDict = SeedUtil.GetDictFromDynamicObject(newCard);
                tableDict.Remove("isSaveForLaterUse");
                tableDict["userId"] = userId;
                tableDict[ "isDefault"]= true;

                Action<Dictionary<string, object>, Dictionary<string, object>, List<Seed>> preSaveActionNewCard = (d1, d2, l) =>
                {                    
                    List<SqlParameter> parms = new List<SqlParameter>();
                    parms.Add(new SqlParameter("userId", userId));
                    seedDataAccess.ExecuteScalar(SqlResource.PaymentMethodsResetDefault, parms);
                };

                Action<Dictionary<string, object>, Dictionary<string, object>, List<Seed>> postSaveActionNewCard = (d1, d2, l) =>
                {
                    var cardId = d2["card"];

                    List<SqlParameter> parms = new List<SqlParameter>();
                    parms.Add(new SqlParameter("cardId", cardId));
                    parms.Add(new SqlParameter("orderImpDetailsId", orderImpDetailsId));
                    seedDataAccess.ExecuteScalar(SqlResource.UpdateCardIdInOrderImpDetails, parms);
                };

                var seedNewCard = new Seed()
                {
                    PKeyColName = "Id",
                    TableName = "PaymentMethods",
                    TableDict = tableDict,
                    IsCustomIDGenerated = false,
                    PostSaveAction = postSaveActionNewCard,
                    PreSaveAction = preSaveActionNewCard,
                    PKeyTagName = "card",
                };
                seedList.Add(seedNewCard);
            }

            return (seedList);
        }
    }
}
