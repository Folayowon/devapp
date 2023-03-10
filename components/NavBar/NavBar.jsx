import React, { useState, useContext } from "react";
import Image from "next/image";
import Link from "next/link";
import { AiFillLock, AiFillUnlock } from "react-icons/ai";
//INTERNAL IMPORT/
import { VotingContext } from "../../context/Voter";
import Style from "./NavBar.module.css";
// import loding from "../../loding.gif";
import logo from "../../Log.svg";

const NavBar = () => {
  const { connectWallet, error, currentAccount } = useContext(VotingContext);
  const [openNav, setOpenNav] = useState(true);

  const openNaviagtion = () => {
    if (openNav) {
      setOpenNav(false);
    } else if (!openNav) {
      setOpenNav(true);
    }
  };
  return (
    <div className={Style.navbar}>
      {error === "" ? (
        ""
      ) : (
        <div className={Style.message__Box}>
          <div style={Style.message}>
            <p className={Style.text}>{error}</p>
          </div>
        </div>
      )}

      <div className={Style.navbar_box}>
        <div className={Style.title}>
          <Link href={{ pathname: "/" }}>
            <Image src={logo} alt="logo" width={100} height={100} />
          </Link>
        </div>
        {/* /NAV SECTION */}
        <div className={Style.nav_flex}>
          {currentAccount && (
            <div className={[Style.navbar_section]}>
              <p>
                <Link href={{ pathname: "/" }}>Home</Link>
              </p>

              <p>
                <Link href={{ pathname: "candidateFactory" }}>
                  Candidates
                </Link>
              </p>
              <p>
                <Link href={{ pathname: "votersFactory" }}>
                  Voters
                </Link>
              </p>

              <p>
                <Link href={{ pathname: "ListOfVoters" }}>Election Summary</Link>
              </p>
            </div>
          )}

          <div className={Style.connect}>
            {currentAccount ? (
              <div>
                <div className={Style.connect_flex}>
                  <button onClick={() => openNaviagtion()}>
                    {currentAccount.slice(0, 10)}..
                  </button>
                  {currentAccount && (
                    <span className={Style.mobile}>
                      {openNav ? (
                        <AiFillUnlock onClick={() => openNaviagtion()} />
                      ) : (
                        <AiFillLock onClick={() => openNaviagtion()} />
                      )}
                    </span>
                  )}
                </div>
                {openNav && (
                  <div className={Style.nav}>
                    <div className={Style.navigation}>
                      <p>
                        <Link href={{ pathname: "/" }}>Home</Link>
                      </p>

                      <p>
                        <Link href={{ pathname: "candidateFactory" }}>
                          Candidates
                        </Link>
                      </p>
                      <p>
                        <Link href={{ pathname: "votersFactory" }}>
                          Voters
                        </Link>
                      </p>

                      <p>
                        <Link href={{ pathname: "ListOfVoters" }}>
                          Election Summary
                        </Link>
                      </p>
                    </div>
                  </div>
                )}
              </div>
            ) : (
              <button onClick={() => connectWallet()}>Connect Wallet</button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default NavBar;
