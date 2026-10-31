
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace CampusPlacementPortal
{
    public partial class PlacementDashboard : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CampusPlacementDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboard();
                LoadStudents();
                LoadPlacements();
            }
        }

        // Load dashboard count
        void LoadDashboard()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand cmd1 = new SqlCommand(
                    "SELECT COUNT(*) FROM Students", con);
                lblStudents.Text = cmd1.ExecuteScalar().ToString();

                SqlCommand cmd2 = new SqlCommand(
                    "SELECT COUNT(*) FROM Companies", con);
                lblCompanies.Text = cmd2.ExecuteScalar().ToString();

                SqlCommand cmd3 = new SqlCommand(
                    "SELECT COUNT(*) FROM Placements WHERE Status = 'Selected'", con);
                lblPlacements.Text = cmd3.ExecuteScalar().ToString();
            }
        }

        // Load student records
        void LoadStudents()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Students ORDER BY StudentID";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }

        // Load placement records
        void LoadPlacements()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        p.PlacementID,
                        s.StudentName,
                        c.CompanyName,
                        c.JobRole,
                        c.Package,
                        p.PlacementDate,
                        p.Status
                    FROM Placements p
                    INNER JOIN Students s
                        ON p.StudentID = s.StudentID
                    INNER JOIN Companies c
                        ON p.CompanyID = c.CompanyID
                    ORDER BY p.PlacementID";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvPlacements.DataSource = dt;
                gvPlacements.DataBind();
            }
        }

        // Display selected placement details
        protected void gvPlacements_SelectedIndexChanged(object sender, EventArgs e)
        {
            int placementID = Convert.ToInt32(
                gvPlacements.SelectedDataKey.Value);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        p.PlacementID,
                        s.StudentName,
                        s.Email,
                        s.Department,
                        s.CGPA,
                        c.CompanyName,
                        c.JobRole,
                        c.Package,
                        c.Location,
                        p.PlacementDate,
                        p.Status
                    FROM Placements p
                    INNER JOIN Students s
                        ON p.StudentID = s.StudentID
                    INNER JOIN Companies c
                        ON p.CompanyID = c.CompanyID
                    WHERE p.PlacementID = @PlacementID";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@PlacementID", placementID);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                da.Fill(dt);

                dvPlacement.DataSource = dt;
                dvPlacement.DataBind();
            }
        }
    }
}
