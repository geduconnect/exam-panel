import CrudTable from "../components/CrudTable";

export default function SubcategoryTable() {
  return (
    <CrudTable
      title="Subcategory"
      endpoint="subcategories"
      columns={["Subcategory Name", "Chapter", "Category", "Subject", "Stream"]}
      hierarchy={[
        { key: "stream_id", label: "Stream", endpoint: "streams" },
        { key: "subject_id", label: "Subject", endpoint: "subjects" },
        { key: "category_id", label: "Category", endpoint: "categories" },
        { key: "chapter_id", label: "Chapter", endpoint: "chapters" },
      ]}
      displayParent={(item) =>
        `${item.stream_name || ""} → ${item.subject_name || ""} → ${
          item.category_name || ""
        } → ${item.chapter_name || ""}`
      }
    />
  );
}
