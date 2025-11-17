import CrudTable from "../components/CrudTable";

export default function SubjectTable() {
  return (
    <CrudTable
      title="Subject"
      endpoint="subjects"
      columns={["Subject Name", "Stream"]}
      hierarchy={[
        { key: "stream_id", label: "Stream", endpoint: "streams" },
      ]}
      displayParent={(item) => item.stream_name || ""}
    />
  );
}
