
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlacementDashboard.aspx.cs" Inherits="CampusPlacementPortal.PlacementDashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Campus Placement Dashboard</title>

    <style>
        body {
            font-family: Arial;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        .container {
            width: 95%;
            margin: auto;
        }

        h1 {
            color: #243b55;
            text-align: center;
        }

        .cards {
            display: flex;
            gap: 20px;
            margin: 25px 0;
        }

        .card {
            flex: 1;
            background: #243b55;
            color: white;
            padding: 22px;
            text-align: center;
            border-radius: 8px;
        }

        .card h2 {
            font-size: 30px;
            margin: 10px;
        }

        .section {
            background: white;
            padding: 20px;
            margin-top: 25px;
            border-radius: 8px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
        }

        .grid th {
            background: #243b55;
            color: white;
            padding: 12px;
        }

        .grid td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .grid tr:nth-child(even) {
            background: #f2f2f2;
        }

        .details {
            width: 100%;
            margin-top: 10px;
        }

        .details td {
            padding: 10px;
            border: 1px solid #ddd;
        }

        .details th {
            background: #243b55;
            color: white;
            padding: 10px;
        }

        @media(max-width:700px) {
            .cards {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="container">

            <h1>Campus Placement Dashboard</h1>

            <div class="cards">

                <div class="card">
                    <h3>Total Students</h3>
                    <h2>
                        <asp:Label ID="lblStudents" runat="server" Text="0"></asp:Label>
                    </h2>
                </div>

                <div class="card">
                    <h3>Total Companies</h3>
                    <h2>
                        <asp:Label ID="lblCompanies" runat="server" Text="0"></asp:Label>
                    </h2>
                </div>

                <div class="card">
                    <h3>Total Placements</h3>
                    <h2>
                        <asp:Label ID="lblPlacements" runat="server" Text="0"></asp:Label>
                    </h2>
                </div>

            </div>

            <div class="section">

                <h2>Student Details</h2>

                <asp:GridView ID="gvStudents" runat="server"
                    AutoGenerateColumns="False"
                    CssClass="grid"
                    EmptyDataText="No student records found">

                    <Columns>
                        <asp:BoundField DataField="StudentID" HeaderText="Student ID" />
                        <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Department" HeaderText="Department" />
                        <asp:BoundField DataField="CGPA" HeaderText="CGPA" />
                        <asp:BoundField DataField="PassingYear" HeaderText="Passing Year" />
                    </Columns>

                </asp:GridView>

            </div>

            <div class="section">

                <h2>Placement Records</h2>

                <asp:GridView ID="gvPlacements" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="PlacementID"
                    CssClass="grid"
                    EmptyDataText="No placement records found"
                    AutoGenerateSelectButton="True"
                    OnSelectedIndexChanged="gvPlacements_SelectedIndexChanged">

                    <Columns>
                        <asp:BoundField DataField="PlacementID" HeaderText="Placement ID" />
                        <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                        <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
                        <asp:BoundField DataField="JobRole" HeaderText="Job Role" />
                        <asp:BoundField DataField="Package" HeaderText="Package (LPA)" DataFormatString="{0:F2}" />
                        <asp:BoundField DataField="PlacementDate" HeaderText="Placement Date" DataFormatString="{0:dd-MM-yyyy}" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                    </Columns>

                </asp:GridView>

            </div>

            <div class="section">

                <h2>Selected Placement Details</h2>

                <asp:DetailsView ID="dvPlacement" runat="server"
                    AutoGenerateRows="True"
                    CssClass="details"
                    GridLines="Both"
                    EmptyDataText="Select a placement record to view details">
                </asp:DetailsView>

            </div>

        </div>

    </form>
</body>
</html>
