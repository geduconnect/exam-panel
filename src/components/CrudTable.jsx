import { useEffect, useState } from "react";
import api from "../api";

export default function CrudTable({
  title,
  endpoint,
  columns = ["Name"],
  hierarchy = [],
  displayParent,
}) {
  const [items, setItems] = useState([]);
  const [parents, setParents] = useState({});
  const [selected, setSelected] = useState({});
  const [loading, setLoading] = useState(true);

  // Modal state
  const [isAddModal, setIsAddModal] = useState(false);
  const [isEditModal, setIsEditModal] = useState(false);
  const [modalValue, setModalValue] = useState("");
  const [editItem, setEditItem] = useState(null);
  const [modalSelected, setModalSelected] = useState({});
  const [modalParents, setModalParents] = useState({});

  useEffect(() => {
    loadFirstLevelParents();
    fetchItems();
  }, []);

  const fetchItems = async () => {
    try {
      const params = {};
      hierarchy.forEach((h) => {
        if (selected[h.key]) params[h.key] = selected[h.key];
      });

      const res = await api.get(`/admin/${endpoint}`, { params });
      setItems(res.data);
      setLoading(false);
    } catch (err) {
      console.error(`Error fetching ${endpoint}:`, err);
    }
  };

  const loadFirstLevelParents = async () => {
    const newParents = {};
    try {
      if (hierarchy.length > 0) {
        const first = hierarchy[0];
        const res = await api.get(`/admin/${first.endpoint}`);
        newParents[first.key] = res.data;
      }
      setParents(newParents);
    } catch (err) {
      console.error("Error loading parents:", err);
    }
  };

  const handleParentChange = async (index, value) => {
    const newSelected = { ...selected };
    newSelected[hierarchy[index].key] = value;

    for (let i = index + 1; i < hierarchy.length; i++) {
      newSelected[hierarchy[i].key] = "";
      setParents((prev) => ({ ...prev, [hierarchy[i].key]: [] }));
    }

    setSelected(newSelected);

    if (hierarchy[index + 1] && value) {
      const next = hierarchy[index + 1];
      try {
        const res = await api.get(`/admin/${next.endpoint}`, {
          params: { [hierarchy[index].key]: value },
        });
        setParents((prev) => ({ ...prev, [next.key]: res.data }));
      } catch (err) {
        console.error("Error loading child:", err);
      }
    }

    fetchItems();
  };

  const loadModalFirstLevel = async () => {
    const newModalParents = {};
    try {
      if (hierarchy.length > 0) {
        const first = hierarchy[0];
        const res = await api.get(`/admin/${first.endpoint}`);
        newModalParents[first.key] = res.data;
      }
      setModalParents(newModalParents);
    } catch (err) {
      console.error("Error loading modal parents:", err);
    }
  };

  const handleModalParentChange = async (index, value) => {
    const newSel = { ...modalSelected };
    newSel[hierarchy[index].key] = value;

    for (let i = index + 1; i < hierarchy.length; i++) {
      newSel[hierarchy[i].key] = "";
      setModalParents((prev) => ({ ...prev, [hierarchy[i].key]: [] }));
    }

    setModalSelected(newSel);

    if (hierarchy[index + 1] && value) {
      const next = hierarchy[index + 1];
      try {
        const res = await api.get(`/admin/${next.endpoint}`, {
          params: { [hierarchy[index].key]: value },
        });
        setModalParents((prev) => ({ ...prev, [next.key]: res.data }));
      } catch (err) {}
    }
  };

  const handleAdd = async (e) => {
    e.preventDefault();
    if (!modalValue.trim()) return alert("Enter a valid name");

    const payload = { name: modalValue };
    hierarchy.forEach((h) => {
      if (modalSelected[h.key]) payload[h.key] = modalSelected[h.key];
    });

    try {
      await api.post(`/admin/${endpoint}`, payload);
      setIsAddModal(false);
      setModalValue("");
      fetchItems();
    } catch (err) {
      alert("Failed to add record");
    }
  };

  const handleEdit = async (e) => {
    e.preventDefault();
    try {
      await api.put(`/admin/${endpoint}/${editItem.id}`, {
        name: modalValue,
      });

      setIsEditModal(false);
      setEditItem(null);
      fetchItems();
    } catch (err) {
      alert("Failed to update record");
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Are you sure?")) return;
    try {
      await api.delete(`/admin/${endpoint}/${id}`);
      fetchItems();
    } catch (err) {
      alert("Failed to delete record");
    }
  };

  return (
    <div className="admin-container">
      <h2 className="title">{title}</h2>

      {/* Hierarchy Filters */}
      {hierarchy.length > 0 && (
        <div className="hierarchy-container">
          {hierarchy.map((h, index) => (
            <div key={h.key} className="form-group">
              <label>{h.label}</label>
              <select
                value={selected[h.key] || ""}
                onChange={(e) => handleParentChange(index, e.target.value)}
              >
                <option value="">Select {h.label}</option>
                {(parents[h.key] || []).map((opt) => (
                  <option key={opt.id} value={opt.id}>
                    {opt.name}
                  </option>
                ))}
              </select>
            </div>
          ))}
        </div>
      )}

      <button
        className="add-btn"
        onClick={() => {
          setIsAddModal(true);
          setModalValue("");
          setModalSelected({ ...selected });
          loadModalFirstLevel();
        }}
      >
        + Add {title}
      </button>

      {/* Table */}
      <table className="crud-table">
        <thead>
          <tr>
            {columns.map((c, i) => (
              <th key={i}>{c}</th>
            ))}
            <th>Actions</th>
          </tr>
        </thead>

        <tbody>
          {loading ? (
            <tr>
              <td colSpan={columns.length + 1}>Loading...</td>
            </tr>
          ) : items.length === 0 ? (
            <tr>
              <td colSpan={columns.length + 1}>No data available</td>
            </tr>
          ) : (
            items.map((item) => (
              <tr key={item.id}>
                <td>{item.name}</td>
                {displayParent && <td>{displayParent(item)}</td>}
                <td>
                  <button
                    className="edit-btn"
                    onClick={() => {
                      setEditItem(item);
                      setModalValue(item.name);
                      setIsEditModal(true);
                    }}
                  >
                    Edit
                  </button>

                  <button
                    className="delete-btn"
                    onClick={() => handleDelete(item.id)}
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))
          )}
        </tbody>
      </table>

      {/* Add Modal */}
      {isAddModal && (
        <Modal
          title={`Add ${title}`}
          value={modalValue}
          setValue={setModalValue}
          onClose={() => setIsAddModal(false)}
          onSubmit={handleAdd}
        >
          {hierarchy.length > 0 && (
            <div className="hierarchy-container">
              {hierarchy.map((h, index) => (
                <div key={h.key} className="form-group">
                  <label>{h.label}</label>
                  <select
                    value={modalSelected[h.key] || ""}
                    onChange={(e) =>
                      handleModalParentChange(index, e.target.value)
                    }
                  >
                    <option value="">Select {h.label}</option>
                    {(modalParents[h.key] || []).map((opt) => (
                      <option key={opt.id} value={opt.id}>
                        {opt.name}
                      </option>
                    ))}
                  </select>
                </div>
              ))}
            </div>
          )}
        </Modal>
      )}

      {/* Edit Modal */}
      {isEditModal && (
        <Modal
          title={`Edit ${title}`}
          value={modalValue}
          setValue={setModalValue}
          onClose={() => setIsEditModal(false)}
          onSubmit={handleEdit}
        />
      )}
    </div>
  );
}

function Modal({ title, value, setValue, onClose, onSubmit, children }) {
  return (
    <div className="modal-overlay">
      <div className="modal-content">
        <h3 className="modal-header">{title}</h3>

        <form onSubmit={onSubmit} className="modal-body">
          {children}

          <input
            type="text"
            value={value}
            onChange={(e) => setValue(e.target.value)}
            placeholder="Enter name"
            required
          />

          <div className="modal-actions">
            <button type="button" className="btn-cancel" onClick={onClose}>
              Cancel
            </button>
            <button type="submit" className="btn-save">
              Save
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
