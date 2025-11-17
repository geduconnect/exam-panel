import CrudTable from "../components/CrudTable";

export default function StreamTable() {
  return (
    <CrudTable
      title="Stream"
      endpoint="streams"
      columns={["Stream Name"]}
    />
  );
}
