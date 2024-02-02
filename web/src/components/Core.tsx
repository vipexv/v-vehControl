import { Transition } from "@mantine/core";
import {
  AlertTriangle,
  ArrowLeft,
  ArrowRight,
  Lightbulb,
  MoveVertical,
  Power,
} from "lucide-react";
import React, { useEffect, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import carSeatIcon from "../icons/carSeat.svg";
import carWheelIcon from "../icons/carWheel.svg";
import doorIcon from "../icons/cardoor.svg";
import hoodIcon from "../icons/carhood.svg";
import revertedDoorIcon from "../icons/dooriconreverted.svg";
import trunkIcon from "../icons/trunk.svg";
import { debugData } from "../utils/debugData";
import { fetchNui } from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";
import "./Core.css";
import IconButton from "./Main/IconButton";
import { VehicleData } from "../types/VehicleData";

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
                <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] h-fit  px-4 py-1 rounded-[2px]">
                  <div className="flex flex-col gap-2 justify-center items-center font-main">
                    <p className="bg-gradient-to-r px-6 py-1  mt-1 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
                      Windows
                    </p>
                    <div className="grid grid-cols-2 gap-2 mb-1">
                      <IconButton Icon={MoveVertical} isActive={false} />
                      <IconButton Icon={MoveVertical} isActive={false} />
                      <IconButton Icon={MoveVertical} isActive={false} />

                      <IconButton Icon={MoveVertical} isActive={false} />
                    </div>
                  </div>
                </div>
                <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] flex-grow px-4 py-1 rounded-[2px]">
                  <div className="flex flex-col gap-2 justify-center items-center font-main">
                    <p className="bg-gradient-to-r px-6 py-1  mt-1 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
                      Seats
                    </p>
                    <div className="grid grid-cols-2 gap-2 mb-1">
                      {Array.from({
                        length: !vehicleData?.seats ? 4 : vehicleData.seats,
                      }).map((_seat, index) => {
                        return (
                          <>
                            <button
                              key={index}
                              onClick={() => {
                                fetchNui("vehmenu:setseat", index);
                              }}
                              className="bg-gradient-to-r from-[#3c3d46] to-[#3c3d46] py-2 px-4 border-[2px] border-[#6c6d75] rounded-sm"
                            >
                              <div
                                className="relative bottom-[5px] right-3 w-2 h-2 rounded-sm blur-[1px]"
                                style={{
                                  backgroundColor: "rgb(225 29 72 / 1)",
                                }}
                              ></div>
                              <img
                                className="relative bottom-[3px] w-[20px]"
                                src={index === 0 ? carWheelIcon : carSeatIcon}
                              />
                            </button>
                          </>
                        );
                      })}
                    </div>
                  </div>
                </div>
                <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] flex-grow px-4 py-1 rounded-[2px]">
                  <div className="flex flex-col gap-2 justify-center items-center font-main">
                    <p className="bg-gradient-to-r px-6 py-1  mt-1 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
                      Doors
                    </p>
                    <div className="flex flex-col gap-2 items-center">
                      {/* Hood and Trunk */}
                      <button
                        className="bg-gradient-to-r from-[#3c3d46] to-[#3c3d46] py-2 px-4 border-[2px] border-[#6c6d75] rounded-sm"
                        onClick={() => {
                          fetchNui("vehmenu:toggledoor", 4);
                        }}
                      >
                        <div
                          className="relative bottom-[5px] right-3 w-2 h-2 rounded-sm blur-[1px]"
                          style={{
                            backgroundColor: "rgb(225 29 72 / 1)",
                          }}
                        ></div>
                        <img
                          className="relative bottom-[3px] w-[20px]"
                          src={hoodIcon}
                        />
                      </button>

                      {/* Doors */}

                      <div className="grid grid-cols-2 gap-2">
                        {Array.from({
                          length: !vehicleData?.doors ? 4 : vehicleData.doors,
                        }).map((_seat, index) => {
                          return (
                            <>
                              <button
                                key={index}
                                onClick={() => {
                                  fetchNui("vehmenu:toggledoor", index);
                                }}
                                className="bg-gradient-to-r from-[#3c3d46] to-[#3c3d46] py-2 px-4 border-[2px] border-[#6c6d75] rounded-sm"
                              >
                                <div
                                  className="relative bottom-[5px] right-3 w-2 h-2 rounded-sm blur-[1px]"
                                  style={{
                                    backgroundColor: "rgb(225 29 72 / 1)",
                                  }}
                                ></div>
                                <img
                                  className="relative bottom-[3px] w-[20px]"
                                  src={revertedDoorIcon}
                                />
                              </button>
                            </>
                          );
                        })}
                      </div>
                      <button
                        className="bg-gradient-to-r from-[#3c3d46] to-[#3c3d46] py-2 px-4 border-[2px] border-[#6c6d75] rounded-sm"
                        onClick={() => {
                          fetchNui("vehmenu:toggledoor", 5);
                        }}
                      >
                        <div
                          className="relative bottom-[5px] right-3 w-2 h-2 rounded-sm blur-[1px]"
                          style={{
                            backgroundColor: "rgb(225 29 72 / 1)",
                          }}
                        ></div>
                        <img
                          className="relative bottom-[3px] w-[20px]"
                          src={trunkIcon}
                        />
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-full h-[10dvh] rounded-[2px]">
                <div className="flex flex-col gap-2 justify-center items-center font-main">
                  <p className="bg-gradient-to-r px-10 py-1 mt-2 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
                    Miscellaneous
                  </p>
                  <div className="flex w-full justify-center items-center gap-2 text-white">
                    <IconButton Icon={Power} isActive={false} />
                    <IconButton Icon={ArrowLeft} isActive={false} />
                    <IconButton Icon={AlertTriangle} isActive={false} />
                    <IconButton Icon={ArrowRight} isActive={false} />
                    <IconButton Icon={Lightbulb} isActive={false} />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </>
      )}
    </Transition>
  );
};

export default Core;
