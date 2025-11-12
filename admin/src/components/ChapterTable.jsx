import CrudTable from "../components/CrudTable";

export default function ChapterTable() {
  return (
    <CrudTable
      title="Chapter"
      endpoint="chapters"
      columns={["Chapter Name", "Category", "Subject", "Stream"]}
      hierarchy={[
        { key: "stream_id", label: "Stream", endpoint: "streams" },
        { key: "subject_id", label: "Subject", endpoint: "subjects" },
        { key: "category_id", label: "Category", endpoint: "categories" },
      ]}
      displayParent={(item) =>
        `${item.stream_name || ""} → ${item.subject_name || ""} → ${
          item.category_name || ""
        }`
      }
    />
  );
}
