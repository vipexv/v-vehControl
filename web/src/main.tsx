import React from "react";
import ReactDOM from "react-dom/client";
import Core from "./components/Core";
import "@mantine/core/styles.css";
import { MantineProvider } from "@mantine/core";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <MantineProvider>
      <Core />
    </MantineProvider>
  </React.StrictMode>
);
