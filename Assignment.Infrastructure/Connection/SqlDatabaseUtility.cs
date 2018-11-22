using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment.Infrastructure.Connection
{
    public class SqlDatabaseUtility
    {
        public static SqlConnection GetConnection()
        {
            string cnstr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cn = new SqlConnection(cnstr);
            cn.Open();
            return cn;
        }

        public static SqlDataReader ExecuteQuery(
            string storedProcName,
            Dictionary<string, SqlParameter> procParameters
        )
        {
            // open a database connection
            SqlConnection cn = GetConnection();

            // create a SQL command to execute the stored procedure
            SqlCommand cmd = new SqlCommand();
            try
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = storedProcName;

                // assign parameters passed in to the command
                foreach (var procParameter in procParameters)
                {
                    cmd.Parameters.Add(procParameter.Value);
                }


            }
            catch (Exception e)
            {
                Console.WriteLine("OOPs, something went wrong.\n" + e);
            }

            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }

        public static int ExecuteCommand(
            string storedProcName,
            Dictionary<string, SqlParameter> procParameters
        )
        {
            int rc;

            using (SqlConnection cn = GetConnection())
            {
                // create a SQL command to execute the stored procedure
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = cn;
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = storedProcName;

                    // assign parameters passed in to the command
                    foreach (var procParameter in procParameters)
                    {
                        cmd.Parameters.Add(procParameter.Value);
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("OOPs, something went wrong.\n" + e);
                }

                rc = cmd.ExecuteNonQuery();
            }

            return rc;
        }
    }
}
