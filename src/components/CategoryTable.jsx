import CrudTable from "../components/CrudTable";

export default function CategoryTable() {
  return (
    <CrudTable
      title="Category"
      endpoint="categories"
      columns={["Category Name", "Subject", "Stream"]}
      hierarchy={[
        { key: "stream_id", label: "Stream", endpoint: "streams" },
        { key: "subject_id", label: "Subject", endpoint: "subjects" },
      ]}
      displayParent={(item) =>
        `${item.stream_name || ""} → ${item.subject_name || ""}`
      }
    />
  );
}
