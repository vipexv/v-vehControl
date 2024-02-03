import { Transition } from "@mantine/core";
import React, { useEffect, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { VehicleData } from "../types/VehicleData";
import { debugData } from "../utils/debugData";
import { fetchNui } from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";
import "./Core.css";
import Doors from "./Main/Doors";
import MiscellaneousActions from "./Main/MiscellaneousActions";
import Seats from "./Main/Seats";
import Windows from "./Main/Windows";

debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

const Core: React.FC = () => {
  const [visible, setVisible] = useState(false);
  const [vehicleData, setVehicleData] = useState<VehicleData | undefined>(
    undefined
  );

  useNuiEvent("nui:state:vehdata", setVehicleData);

  useNuiEvent<boolean>("setVisible", setVisible);

  useEffect(() => {
    if (!visible) return;

    const keyHandler = (e: KeyboardEvent) => {
      if (["Escape"].includes(e.code)) {
        if (!isEnvBrowser()) fetchNui("hideFrame");
        else setVisible(!visible);
      }
    };

    window.addEventListener("keydown", keyHandler);

    return () => window.removeEventListener("keydown", keyHandler);
  }, [visible]);

  return (
    <Transition
      mounted={visible}
      duration={400}
      transition={"slide-up"}
      timingFunction="ease"
    >
      {(styles) => (
        <>
          <div
            style={styles}
            className="flex w-[100dvw] h-[100dvh] justify-center items-end"
          >
            <div className="flex flex-col gap-2 mb-10 justify-center items-center">
              <div className="flex items-end  gap-4 text-white">
                <Windows vehicleData={vehicleData} />
                <Seats vehicleData={vehicleData} />
                <Doors vehicleData={vehicleData} />
              </div>
              <MiscellaneousActions vehicleData={vehicleData} />
            </div>
          </div>
        </>
      )}
    </Transition>
  );
};

export default Core;
